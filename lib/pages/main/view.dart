import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class MainPage extends StatelessWidget {
  final TextEditingController valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child:
                  BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                if (state is InitState) {
                  return Column(
                    children: [
                      const Text('Скільки ключиків тобі потрібно?'),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextField(
                                maxLines: 1,
                                controller: valueController,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(30)),
                              ),
                              onPressed: () {
                                if (valueController.text.isEmpty) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent());
                                }

                                var value = int.parse(valueController.text);
                                if (value < 1) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent());
                                  return;
                                }

                                BlocProvider.of<MainBloc>(context)
                                    .add(GetKeysEvent(value));
                              },
                              child: const Text('Згенерувати'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                if (state is EmptyAmountState) {
                  return Column(
                    children: [
                      const Text('Скільки ключиків тобі потрібно?'),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextField(
                                maxLines: 1,
                                controller: valueController,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(30)),
                              ),
                              onPressed: () {
                                if (valueController.text.isEmpty) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent());
                                }
                                var value = int.parse(valueController.text);
                                if (value < 1) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent());
                                  return;
                                }

                                BlocProvider.of<MainBloc>(context)
                                    .add(GetKeysEvent(value));
                              },
                              child: const Text('Згенерувати'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                          "Нє, так справи не робляться, мені треба кількість"),
                    ],
                  );
                }

                if (state is ResultState) {
                  return Column(
                    children: [
                      const Text('Скільки ключиків тобі потрібно?'),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextField(
                                maxLines: 1,
                                controller: valueController,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(30)),
                              ),
                              onPressed: () {
                                if (valueController.text.isEmpty) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent());
                                }
                                var value = int.parse(valueController.text);
                                if (value < 1) {
                                  BlocProvider.of<MainBloc>(context)
                                      .add(EmptyAmountEvent());
                                  return;
                                }

                                BlocProvider.of<MainBloc>(context)
                                    .add(GetKeysEvent(value));
                              },
                              child: const Text('Згенерувати'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.keys.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          prototypeItem: ListTile(
                            title: Text(state.keys.first),
                          ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Center(
                                  child: ElemKey(state.keys[index], index)),
                            );
                          },
                        ),
                      )
                    ],
                  );
                }

                return const Text('ERROR');
              }),
            ),
          ),
        ));
  }
}

class ElemKey extends StatelessWidget {
  String bodyKey;
  bool flag = true;
  int keyNum;

  ElemKey(this.bodyKey, this.keyNum);

  @override
  Widget build(BuildContext context) {
    keyNum++;
    return Center(
      child: BlocProvider<ElemBloc>(
          create: (BuildContext context) => ElemBloc(),
          child: BlocBuilder<ElemBloc, ElemState>(builder: (context, state) {
            if (flag) {
              BlocProvider.of<ElemBloc>(context).add(InitElemEvent());
            }
            if (state is InitElemState) {
              return Card(
                color: Colors.white,
                elevation: 0,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          keyNum.toString(),
                        ),
                      ),
                    ),
                    Align(
                      child: Text(
                        bodyKey,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            flag = false;
                            await Clipboard.setData(
                                ClipboardData(text: bodyKey));
                            BlocProvider.of<ElemBloc>(context)
                                .add(CopyElemEvent());
                          },
                          child: const Text('Копіювати'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CopyElemState) {
              return Card(
                color: Colors.redAccent,
                elevation: 0,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          keyNum.toString(),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        bodyKey,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            flag = false;
                            await Clipboard.setData(
                                ClipboardData(text: bodyKey));
                            BlocProvider.of<ElemBloc>(context)
                                .add(CopyElemEvent());
                          },
                          child: const Text('Копіювати'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('ERROR');
            }
          })),
    );
  }
}
