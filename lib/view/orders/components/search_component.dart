import 'package:flutter/material.dart';

class SearchComponent extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchComponent({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search order ID, customer...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}

class AnimatedSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const AnimatedSearchBar({super.key, required this.onChanged});

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        boxShadow: isFocused ? [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 10, offset: const Offset(0, 4))] : [],
      ),
      child: Focus(
        onFocusChange: (v) => setState(() => isFocused = v),
        child: SearchComponent(onChanged: widget.onChanged),
      ),
    );
  }
}
