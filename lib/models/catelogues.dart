class Catelogue {
  Catelogue({
    required this.title,
    required this.illustration,
  });

  String title;
  String illustration;
}

var catelogueList = [
  Catelogue(
    title: 'Gaming',
    illustration: 'assets/images/image-1.jpg',
  ),
  Catelogue(
    title: 'Tech',
    illustration: 'assets/images/image-2.jpg',
  ),
  Catelogue(
    title: 'Security',
    illustration: 'assets/images/image-3.jpg',
  ),
  Catelogue(
    title: 'Cryptocurrency',
    illustration: 'assets/images/image-4.jpg',
  ),
];