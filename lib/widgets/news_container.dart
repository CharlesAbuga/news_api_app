import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui/widgets/bottom_sheet.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer(
      {super.key,
      required this.imageUrl,
      required this.description,
      required this.title,
      required this.url,
      required this.author,
      required this.publishedAt});
  final String imageUrl;
  final String title;
  final String description;
  final String url;

  final String author;
  final String publishedAt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            context: context,
            builder: (context) {
              return BottomSheetContent(
                  author: author,
                  publishedAt: publishedAt,
                  imageUrl: imageUrl,
                  title: title,
                  description: description,
                  url: url);
            });
      },
      child: Row(
        children: [
          Positioned(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  width: 100,
                  height: 100,
                  imageUrl: imageUrl,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.length > 100 ? '${title.substring(0, 100)}...' : title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      author.length > 20
                          ? '${author.substring(0, 20)}...'
                          : author,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 10),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  publishedAt,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 8,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
