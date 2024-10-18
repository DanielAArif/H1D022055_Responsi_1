import 'package:flutter/material.dart';
import '../bloc/pemandu_wisata_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/pemandu_wisata.dart';
import '/ui/pemandu_wisata_form.dart';
import 'pemandu_wisata_page.dart';

// ignore: must_be_immutable
class PemanduWisataDetail extends StatefulWidget {
  PemanduWisata? pemanduWisata;
  PemanduWisataDetail({Key? key, this.pemanduWisata}) : super(key: key);
  @override
  _PemanduWisataDetailState createState() => _PemanduWisataDetailState();
}

class _PemanduWisataDetailState extends State<PemanduWisataDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pemandu Wisata'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Nama Guide : ${widget.pemanduWisata!.guide}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Languages : ${widget.pemanduWisata!.languages}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Rating : ${widget.pemanduWisata!.rating}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
// Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PemanduWisataForm(
                  pemanduWisata: widget.pemanduWisata!,
                ),
              ),
            );
          },
        ),
// Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
//tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            PemanduWisataBloc.deletePemanduWisata(id: widget.pemanduWisata!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PemanduWisataPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
//tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
