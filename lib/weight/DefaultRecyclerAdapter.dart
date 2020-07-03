import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/weight/RecyclerView.dart';

class DefaultRecyclerAdapter extends Adapter<DefaultViewHolder> {
  List<String> items = [];

  DefaultRecyclerAdapter() {
//    addItem('abc');
//    addItem('123');
  }

  void addItem(String name) {
    items.add(name);
  }

  void clear() {
    items.clear();
  }

  @override
  int getItemCount() {
    return items.length;
  }

  @override
  void onBindViewHolder(DefaultViewHolder holder, int position) {
    holder.item = items[position];
  }

  @override
  DefaultViewHolder onCreateViewHolder() {
    return new DefaultViewHolder();
  }
}

class DefaultViewHolder extends ViewHolder {
  String item;

  @override
  Widget onBuild() {
    return Card(
      child: Text(item,
          style: TextStyle(fontSize: 18.0, height: 2),
          textAlign: TextAlign.center),
      margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
      color: Colors.white60,
    );
  }
}
