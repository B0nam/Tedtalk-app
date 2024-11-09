import 'package:flutter/material.dart';
import 'package:tedtalk/models/ted_talk.dart';

class TedTalkDialog extends StatelessWidget {
  final TedTalk? tedTalk;

  const TedTalkDialog({Key? key, this.tedTalk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: tedTalk?.name ?? '');
    TextEditingController speakerController =
        TextEditingController(text: tedTalk?.speaker ?? '');
    TextEditingController descriptionController =
        TextEditingController(text: tedTalk?.description ?? '');
    TextEditingController durationController = TextEditingController(
        text: tedTalk != null ? tedTalk!.duration.inMinutes.toString() : '');
    TextEditingController imageController =
        TextEditingController(text: tedTalk?.image ?? '');

    return AlertDialog(
      title: Text(tedTalk == null ? 'Adicionar TED Talk' : 'Editar TED Talk'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Nome do TED Talk')),
          TextField(
              controller: speakerController,
              decoration: const InputDecoration(hintText: 'Palestrante')),
          TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: 'Descrição')),
          TextField(
              controller: durationController,
              decoration:
                  const InputDecoration(hintText: 'Duração (em minutos)'),
              keyboardType: TextInputType.number),
          TextField(
              controller: imageController,
              decoration: const InputDecoration(hintText: 'URL da Imagem')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final newId =
                tedTalk?.id ?? DateTime.now().millisecondsSinceEpoch.toString();

            final updatedTedTalk = TedTalk(
              id: newId,
              name: nameController.text,
              speaker: speakerController.text,
              description: descriptionController.text,
              duration:
                  Duration(minutes: int.tryParse(durationController.text) ?? 0),
              image: imageController.text,
            );

            Navigator.of(context).pop(updatedTedTalk);
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
