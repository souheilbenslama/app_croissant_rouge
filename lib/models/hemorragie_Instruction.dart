class HemorragieInstruction {
  final String title;
  final String img;
  final String steps;
  final bool needButton;
  bool alerteSecoure;
  bool needSecouriste;

  HemorragieInstruction(
      {this.title,
      this.img,
      this.steps,
      this.needButton,
      this.alerteSecoure,
      this.needSecouriste});
}
