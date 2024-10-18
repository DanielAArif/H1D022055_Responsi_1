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
        backgroundColor: const Color.fromARGB(255, 125, 125, 125),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Georgia',
        ), // Judul warna putih
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Colors.grey[200], // Warna card
            elevation: 8, // Tambahkan bayangan pada card besar
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Agar card menyesuaikan konten
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menampilkan informasi Nama Guide, Languages, dan Rating dalam satu card
                  Text(
                    "Nama Guide : ${widget.pemanduWisata!.guide}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: 'Georgia',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Languages : ${widget.pemanduWisata!.languages}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: 'Georgia',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Rating : ${widget.pemanduWisata!.rating}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: 'Georgia',
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tombol Edit dan Delete berada di tengah card secara horizontal
                  Center(child: _tombolHapusEdit()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Tombol di tengah card
      children: [
        // Tombol Edit
        OutlinedButton(
          child: Text("EDIT"),
          style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
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
        const SizedBox(width: 10),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, // Warna teks hitam
          ),
          onPressed: () {
            PemanduWisataBloc.deletePemanduWisata(id: widget.pemanduWisata!.id!)
                .then(
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
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, // Warna teks hitam
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
