import 'package:champions/models/champion.dart';
import 'package:champions/pages/champions/champions_create.dart';
import 'package:champions/pages/champions/champions_edit.dart';
import 'package:champions/pages/champions/champions_hobbies.dart';
import 'package:champions/services/champion_service.dart';
import 'package:flutter/material.dart';

class ChampionsIndex extends StatefulWidget {
  const ChampionsIndex({Key? key}) : super(key: key);

  @override
  State<ChampionsIndex> createState() => _ChampionsIndexState();
}

class _ChampionsIndexState extends State<ChampionsIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Champions Index'),
      ),
      body: FutureBuilder<List<Champion>>(
        future: ChampionService().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return _championsIndex(snapshot.data!, context);
        },
      ),
floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _createChampion(context),
      ),
    );
  }

  Widget _championsIndex(List<Champion> list, BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: _championHobbies(list[index], context),
          title: Row(
            children: [
              Expanded(child: Text(list[index].naam)),
              _editChampion(list[index], context),
              _deleteChampion(list[index].id, context)
            ],
          ),
          subtitle: Text('Aantal hobbies: ${list[index].hobbies?.length ?? 0}'),
        );
      },
    );
  }

  Future<void> _createChampion(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ChampionsCreate(),
    ));
    setState(() {});
  }

  Widget _editChampion(Champion champion, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChampionsEdit(champion: champion),
        ));
        setState(() {});
      },
      child: const Icon(Icons.edit),
    );
  }

  Widget _deleteChampion(int id, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool gelukt = await ChampionService().delete(id);
        if (gelukt) {
          setState(() {});
        } else {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Champions - Delete'),
                  content: const Text('Verwijderen is mislukt'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Ok'))
                  ],
                );
              },
            );
          }
        }
      },
      child: const Icon(Icons.delete_outline),
    );
  }

  Widget _championHobbies(Champion champion, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChampionsHobbiesPage(champion: champion),
        ));
        setState(() {});
      },
      child: const Icon(Icons.account_box_outlined),
    );
  }
}
