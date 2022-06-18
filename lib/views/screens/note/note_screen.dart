import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:brain_saver_flutter/views/components/components.dart';
import 'package:brain_saver_flutter/views/screens/note/cubit/note_cubit.dart';
import 'package:brain_saver_flutter/views/theme/style_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class _TitleInput extends StatefulWidget {
  const _TitleInput({Key? key}) : super(key: key);

  @override
  _TitleInputState createState() => _TitleInputState();
}

class _TitleInputState extends State<_TitleInput> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<NoteCubit, NoteState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        if (_controller!.text.isEmpty)
          _controller = TextEditingController(text: state.title);
        return Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              context.read<NoteCubit>().saveNotes(user.id);
            }
          },
          child: TextFormField(
            controller: _controller,
            onChanged: (title) {
              context.read<NoteCubit>().titleChanged(title);
            },
            decoration: const InputDecoration(
              hintText: 'Title of your note',
            ),
            style: Theme.of(context).textTheme.headline2,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            enableSuggestions: false,
          ),
        );
      },
    );
  }
}

class _NoteField extends StatefulWidget {
  const _NoteField({Key? key}) : super(key: key);

  @override
  _NoteFieldState createState() => _NoteFieldState();
}

class _NoteFieldState extends State<_NoteField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<NoteCubit, NoteState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        if (_controller!.text.isEmpty)
          _controller = TextEditingController(text: state.notes);
        return Expanded(
          child: Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                context.read<NoteCubit>().saveNotes(user.id);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(1.4, 1.4),
                      blurRadius: 10.0),
                ],
              ),
              child: TextFormField(
                controller: _controller,
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
                    borderRadius:
                        BorderRadius.all(Radius.circular(BORDERRADIUS)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(BORDERRADIUS)),
                  ),
                  counterText: '${1000 - state.notes.length} characters left',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
