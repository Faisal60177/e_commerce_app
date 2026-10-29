import 'package:e_commerce_app/core/utils/debouncer.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/widgets/app_empty_view.dart';
import 'package:e_commerce_app/features/products/application/product_list_provider.dart';
import 'package:e_commerce_app/features/products/application/product_query.dart';
import 'package:e_commerce_app/features/products/application/recent_searches_provider.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_grid_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();

}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  final _debouncer = Debouncer();
  String _query = '';

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    final text = value.trim();
    if(text.isEmpty) {
      _debouncer.cancel();
      setState(() => _query = '');
      return;
    }
    setState(() {});
    _debouncer.run(() {
      if(mounted) setState(() => _query = text);
    });
  }
  
  void _submit(String value) {
    final text = value.trim();
    if(text.isEmpty) return;
    _debouncer.cancel();
    setState(() => _query = text);
    ref.read(recentSearchesProvider.notifier).add(text);
  }

  void _useRecent(String text){
    _controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    _submit(text);
  }

  void _clear(){
    _debouncer.cancel();
    _controller.clear();
    setState(() => _query = '');
  }

  bool _onScroll(ScrollNotification notification) {
    if(notification.depth == 0 && notification.metrics.extentAfter < 600) {
      ref.read(productListProvider(ProductQuery(search: _query)).notifier)
          .loadMore();
    }return false;

  }

@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onChanged: _onChanged,
          onSubmitted: _submit,
          decoration: InputDecoration(
            hintText: 'Search products',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: _controller.text.isEmpty
              ? null
                : IconButton(onPressed: _clear, icon: const Icon(Icons.close_rounded),
            )
          ),
        ),
        actions: const [
          SizedBox(width: 1)],
      ),
      body: _query.isEmpty
      ? _RecentSearches(onSelect: _useRecent)
      : NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 8,),),
              ProductGridSliver(query: ProductQuery(search: _query),
              emptyTitle: 'No results for "$_query"',
                emptySubtitle: 'Try a different keyword.',
              )
            ],
          )),
    );
}
}

class _RecentSearches extends ConsumerWidget{
  const _RecentSearches({required this.onSelect});
  final ValueChanged<String> onSelect;

@override
Widget build(BuildContext context, WidgetRef ref) {
  final recent = ref.watch(recentSearchesProvider);
  final notifier = ref.read(recentSearchesProvider.notifier);
  
  if(recent.isEmpty) {
    return const AppEmptyView(icon: Icons.search_rounded,
        title: 'Search for products',
      subtitle: 'Try "phone", "laptop" or "shoes".',);
  }
  return ListView(
    children: [
      Padding(padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
      child: Row(
        children: [
          Expanded(child: Text('Recent searches',style: context.textTheme.titleMedium,
          )),
          TextButton(onPressed: notifier.clear, child: const Text('Clear')),
        ],
      ),),
      for (final query in recent)
        ListTile(
          leading: const Icon(Icons.history_rounded),
          title: Text(query),
          trailing: IconButton(onPressed: () => notifier.remove(query), icon: const Icon(Icons.close_rounded),
          ),
          onTap: () => onSelect(query),
        )
    ],
  );
}
}