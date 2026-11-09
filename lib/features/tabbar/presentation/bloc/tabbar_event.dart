abstract class TabbarEvent {}

class TabChanged extends TabbarEvent {
  final int index;

  TabChanged(this.index);
}
