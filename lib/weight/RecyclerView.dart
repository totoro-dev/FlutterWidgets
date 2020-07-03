import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 一个对标安卓使用方式的RecyclerView，并做部分扩展
///
///
class RecyclerView extends StatefulWidget {
  List<ViewHolder> _mItems = [];
  Adapter _mAdapter;
  _RecyclerViewState _mState;

  void setAdapter(Adapter adapter) {
    this._mAdapter = adapter;
    this._mAdapter._mRecyclerView = this;
  }

  Adapter getAdapter() => _mAdapter;

  _RecyclerViewState getRecyclerViewState() => _mState;

  @override
  _RecyclerViewState createState() {
    _mItems.clear();
    return _mState = _RecyclerViewState();
  }
}

class _RecyclerViewState extends State<RecyclerView> {
  @override
  Widget build(BuildContext context) {
    RecyclerView parent = widget;
    print(parent.getAdapter().getItemCount());
    return ListView.builder(
      itemBuilder: (context, index) {
        print('create item position = ' + index.toString());
        return ItemWidget(parent, index);
      },
      itemCount: parent.getAdapter().getItemCount(),
      shrinkWrap: true,
    );
  }
}

class ItemWidget extends StatefulWidget {
  _ItemWidgetState _mWidgetState;
  RecyclerView _mRecyclerView;
  int _mPosition = -1;

  bool equals(ItemWidget other) {
    return this == other && _mPosition == other._mPosition && _mPosition != -1;
  }

  ItemWidget(this._mRecyclerView, this._mPosition) {
    try {
      if (this._mRecyclerView == null) throw NullThrownError();
    } on NullThrownError catch (e) {
      print(e);
    }
  }

  @override
  _ItemWidgetState createState() {
    _mWidgetState ??= _ItemWidgetState();
    _mWidgetState.setViewHolder(_mRecyclerView.getAdapter().onCreateViewHolder());
    _mWidgetState.getViewHolder()._setPosition(_mPosition);
    _mRecyclerView._mItems.add(_mWidgetState.getViewHolder());
    return _mWidgetState;
  }
}

class _ItemWidgetState extends State<ItemWidget> {
  ViewHolder _mViewHolder;

  void setViewHolder(holder) => _mViewHolder = holder;
  ViewHolder getViewHolder() => _mViewHolder;

  @override
  Widget build(BuildContext context) {
    ItemWidget _mItemWidget = widget;
    _mItemWidget._mRecyclerView
        .getAdapter()
        .onBindViewHolder(_mViewHolder, _mViewHolder.getPosition());
    return _mViewHolder.onBuild();
  }
}

abstract class Adapter<VH extends ViewHolder> {
  RecyclerView _mRecyclerView;

  /// 在这里提供
  VH onCreateViewHolder();

  /// 当初始化或者刷新列表时，需要对holder进行绑定数据
  void onBindViewHolder(VH holder, int position);

  int getItemCount(); // 获取列表中列表项的数量

  /// 列表的数据集合发生变化，通过设置列表的状态从而刷新列表
  void notifyDataSetChanged() {
    if (_mRecyclerView == null) return;
    _mRecyclerView.getRecyclerViewState().setState(() {
      print('刷新列表');
    });
  }
}

abstract class ViewHolder {
  int _mPosition; // 当前这个holder在列表中的显示位置

  /// 获取这个holder的当前位置
  int getPosition() => _mPosition;

  /// 设置这个holder的当前位置，目前为私有
  void _setPosition(position) => _mPosition = position;

  ViewHolder();

  /// 需要提供一个组件来构建这个ViewHolder
  /// 相当于一个列表项
  Widget onBuild();
}
