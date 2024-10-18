import 'package:flutter/material.dart';
import '../bloc/pemandu_wisata_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/pemandu_wisata.dart';
import 'pemandu_wisata_page.dart';

// ignore: must_be_immutable
class PemanduWisataForm extends StatefulWidget {
  PemanduWisata? pemanduWisata;
  PemanduWisataForm({Key? key, this.pemanduWisata}) : super(key: key);
  @override
  _PemanduWisataFormState createState() => _PemanduWisataFormState();
}

class _PemanduWisataFormState extends State<PemanduWisataForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PEMANDU WISATA";
  String tombolSubmit = "SIMPAN";
  final _guideTextboxController = TextEditingController();
  final _languagesTextboxController = TextEditingController();
  final _ratingTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.pemanduWisata != null) {
      setState(() {
        judul = "UBAH PEMANDU WISATA";
        tombolSubmit = "UBAH";
        _guideTextboxController.text = widget.pemanduWisata!.guide!;
        _languagesTextboxController.text = widget.pemanduWisata!.languages!;
        _ratingTextboxController.text = widget.pemanduWisata!.rating.toString();
      });
    } else {
      judul = "TAMBAH PEMANDU WISATA";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _guideTextField(),
                _languagesTextField(),
                _ratingTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox Guide
  Widget _guideTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Guide"),
      keyboardType: TextInputType.text,
      controller: _guideTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kolom Guide harus diisi";
        }
        return null;
      },
    );
  }
  
  //Membuat Textbox Languages
  Widget _languagesTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Languages"),
      keyboardType: TextInputType.text,
      controller: _languagesTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kolom Languages harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Rating
  Widget _ratingTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Rating"),
      keyboardType: TextInputType.number,
      controller: _ratingTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kolom Rating harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.pemanduWisata != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    PemanduWisata createPemanduWisata = PemanduWisata(id: null);
    createPemanduWisata.guide = _guideTextboxController.text;
    createPemanduWisata.languages = _languagesTextboxController.text;
    createPemanduWisata.rating = int.parse(_ratingTextboxController.text);
    PemanduWisataBloc.addPemanduWisata(pemanduWisata: createPemanduWisata).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PemanduWisataPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    PemanduWisata updatePemanduWisata = PemanduWisata(id: widget.pemanduWisata!.id!);
    updatePemanduWisata.guide = _guideTextboxController.text;
    updatePemanduWisata.languages = _languagesTextboxController.text;
    updatePemanduWisata.rating = int.parse(_ratingTextboxController.text);
    PemanduWisataBloc.updatePemanduWisata(pemanduWisata: updatePemanduWisata).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PemanduWisataPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
