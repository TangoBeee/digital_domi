import 'package:digital_domi/providers/map_visibility_controller.dart';
import 'package:digital_domi/utils/image_to_bitmap.dart';
import 'package:digital_domi/widgets/bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  final ValueChanged<bool> dialogToggleFunc;

  const MapView({required this.dialogToggleFunc, super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _controller;
  final Set<Polygon> _polygons = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkerIcon();
  }

  Future<void> _loadMarkerIcon() async {
    final markerIcon = await ImageToMarkerBitmap.getMarkerIcon(
        "lib/assets/images/location_image.jpeg", const Size(64, 64));

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId("100_martinique_ave"),
          position: const LatLng(27.9085526, -82.4594368),
          icon: markerIcon,
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;

    Provider.of<MapVisibilityController>(context, listen: false).showMap();
  }

  void _onTap(LatLng position) {
    setState(() {
      widget.dialogToggleFunc(true);

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return BottomDialog(dialogToggleFunc: widget.dialogToggleFunc);
        },
      ).whenComplete(() => widget.dialogToggleFunc(false));

      _polygons.clear();

      _polygons.add(
        Polygon(
          polygonId: const PolygonId('highlighted_area'),
          points: [
            LatLng(position.latitude + 0.0001, position.longitude - 0.0001),
            LatLng(position.latitude + 0.0001, position.longitude + 0.0001),
            LatLng(position.latitude - 0.0001, position.longitude + 0.0001),
            LatLng(position.latitude - 0.0001, position.longitude - 0.0001),
          ],
          fillColor: Colors.yellow.withOpacity(0.5),
          strokeColor: Colors.yellow,
          strokeWidth: 1,
        ),
      );

      _controller
          ?.moveCamera(
            CameraUpdate.newLatLng(position),
          )
          .then((_) => {
                _controller?.animateCamera(
                  CameraUpdate.zoomTo(17.25),
                )
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          compassEnabled: false,
          initialCameraPosition: const CameraPosition(
            target: LatLng(27.9070051, -82.4590600),
            zoom: 17.25,
          ),
          markers: _markers,
          cloudMapId: 'af3e253b431e83e3',
          zoomControlsEnabled: false,
          polygons: _polygons,
          onTap: _onTap,
        ),
        Consumer<MapVisibilityController>(
          builder: (context, model, child) {
            return model.isMapLoading
                ? Container(
                    color: Colors.black,
                    child: const Center(
                        child: Text(
                      "Loading...",
                      style: TextStyle(color: Colors.green),
                    )),
                  )
                : Container();
          },
        ),
      ],
    );
  }
}
