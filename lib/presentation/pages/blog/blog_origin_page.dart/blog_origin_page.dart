import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogOriginPage extends ConsumerWidget {
  const BlogOriginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 드래그 핸들
            Container(
              height: 22,
              alignment: Alignment.center,
              child: Container(
                width: 36,
                height: 5,
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemGrey4,
                  borderRadius: BorderRadius.all(Radius.circular(2.5)),
                ),
              ),
            ),
            // 컨텐츠
            Expanded(
              child: Column(
                children: [
                  const CupertinoAppBar(
                    title: Text('블로그 선택'),
                    leading: CloseButton(),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 20,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return const CupertinoListTile(
                          title: Text('블로그 항목'),
                          trailing: CupertinoListTileChevron(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(12),
      child: const Icon(
        CupertinoIcons.xmark,
        size: 20,
        color: CupertinoColors.systemGrey,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class CupertinoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CupertinoAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  final Widget title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBackground,
        border: Border(bottom: BorderSide(color: CupertinoColors.systemGrey5)),
      ),
      child: NavigationToolbar(
        leading: leading != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: leading,
              )
            : null,
        middle: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.label,
            letterSpacing: -0.5,
          ),
          child: title,
        ),
        trailing: trailing != null
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: trailing,
              )
            : null,
      ),
    );
  }
}

class CupertinoListTile extends StatelessWidget {
  const CupertinoListTile({
    super.key,
    required this.title,
    this.trailing,
  });

  final Widget title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 17,
                color: CupertinoColors.label,
              ),
              child: title,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class CupertinoListTileChevron extends StatelessWidget {
  const CupertinoListTileChevron({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.chevron_forward,
      size: 20,
      color: CupertinoColors.systemGrey2,
    );
  }
}

class SiteIcon extends StatelessWidget {
  const SiteIcon({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 48,
      child: Image.network(url),
    );
  }
}
