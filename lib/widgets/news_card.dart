import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  const NewsCard(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/placeholder_image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.length > 40 ? '${title.substring(0, 40)}...' : title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Icon(Icons.bookmark,
                    color: Theme.of(context).colorScheme.onSecondary),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                  description.length > 100
                      ? '${description.substring(0, 100)}...'
                      : description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSecondary)),
            ),
          ),
        ],
      ),
    );
  }
}
