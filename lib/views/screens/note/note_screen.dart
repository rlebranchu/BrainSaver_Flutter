import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/views/components/components.dart';
import 'package:brain_saver_flutter/views/components/textformfield_app.dart';
import 'package:brain_saver_flutter/views/screens/note/cubit/note_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, 0),
        child: BlocProvider(
          create: (_) => NoteCubit(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _TitleInput(),
              const SizedBox(height: 26),
              _NoteField(),
            ],
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Align(
          alignment: const Alignment(0, 0),
          child: BlocProvider(
            create: (_) => NoteCubit(NoteRepository(), user.id),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _TitleInput(),
                const SizedBox(height: 26),
                _NoteField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextFieldApp(
          initialValue: state.title,
          onChange: (title) {
            context.read<NoteCubit>().titleChanged(title);
          },
          label: 'Title of your note',
          textAlign: TextAlign.center,
        );
      },
    );
  }
}

class _NoteField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      buildWhen: (previous, current) => previous.notes != current.notes,
      builder: (context, state) {
        return Expanded(
          child: TextField(
            onChanged: (notes) {
              context.read<NoteCubit>().notesChanged(notes);
            },
            keyboardType: TextInputType.multiline,
            maxLength: 1000,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              counterText: '${1000 - state.notes.length} characters left',
            ),
          ),
        );
      },
    );
  }
}
