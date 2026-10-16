import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  final String productID;
  const ShareProductButton({super.key, required this.productID});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final productLink =
            'https://eccomerce-huma-volve.web.app/products/$productID';
        final String shareMessage = "Look at this product: $productLink";
        await SharePlus.instance.share(
          ShareParams(
            text: shareMessage,
            subject: "Check out this product on Huma Volve",
          ),
        );
      },
      icon: Icon(Icons.share),
    );
  }
}
