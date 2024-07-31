import 'package:digital_domi/utils/document_utils.dart';
import 'package:flutter/material.dart';
import 'package:digital_domi/models/document_model.dart';

class DomiDocsSection extends StatefulWidget {
  final List<Document> docsDetail;

  const DomiDocsSection({required this.docsDetail, super.key});

  @override
  State<DomiDocsSection> createState() => _DomiDocsSectionState();
}

class _DomiDocsSectionState extends State<DomiDocsSection> {
  late TextEditingController _searchController;
  List<Document> _filteredDocs = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_filterDocs);
    _filteredDocs = widget.docsDetail;
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterDocs);
    _searchController.dispose();
    super.dispose();
  }

  void _filterDocs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDocs = widget.docsDetail
          .where((doc) => doc.title.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff111111),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader("dōmi docs", () {}),
              const SizedBox(height: 8),
              _buildSearchField(),
              const SizedBox(height: 25),
              _buildDocsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerRight,
            enableFeedback: false,
            splashFactory: NoSplash.splashFactory,
            overlayColor: Colors.transparent,
          ),
          child: const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Colors.white,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      style: const TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          decorationThickness: 0),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        hintText: "Search docs",
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
        filled: true,
        fillColor: const Color(0xff1c1c1c),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDocsList() {
    return Column(
      children: List.generate(_filteredDocs.length, (index) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: index == _filteredDocs.length - 1 ? 0 : 16.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xff1c1c1c),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  DocumentUtils.getDocumentIcon(_filteredDocs[index].title),
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _filteredDocs[index].title,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _filteredDocs[index].lastOpen,
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
