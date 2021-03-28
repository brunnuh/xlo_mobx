import 'package:mobx/mobx.dart';

part 'page_store.g.dart';

class PageStore = _PageStore with _$PageStore;

abstract class _PageStore with Store{
 // Observers
 @observable
  int page = 0;

 
 
 // Action
 @action
  void setPage(int value) => page = value;
 
 
 //Computed

}