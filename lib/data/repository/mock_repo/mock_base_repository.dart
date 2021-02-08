abstract class MockBaseRepository<T> {
  List<T> getEnWordsItems();

  List<String> getRusWordsList();

  List<T> genRusWordsItems(int id);
}
