import 'package:flutter/material.dart';
import 'package:h1d022055_responsi1/model/pemandu_wisata.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/pemandu_wisata_bloc.dart';
import '/ui/pemandu_wisata_detail.dart';
import '/ui/pemandu_wisata_form.dart';
import 'login_page.dart';

class PemanduWisataPage extends StatefulWidget {
  const PemanduWisataPage({Key? key}) : super(key: key);
  @override
  _PemanduWisataPageState createState() => _PemanduWisataPageState();
}

class _PemanduWisataPageState extends State<PemanduWisataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Pemandu Wisata',
          style: TextStyle(
              fontFamily: 'Georgia', color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 125, 125, 125),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.white),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PemanduWisataForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(fontFamily: 'Georgia', color: Colors.black),
              ),
              trailing: const Icon(Icons.logout, color: Colors.black),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: PemanduWisataBloc.getPemanduWisatas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListPemanduWisata(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListPemanduWisata extends StatelessWidget {
  final List? list;
  const ListPemanduWisata({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemPemanduWisata(
            pemanduWisata: list![i],
          );
        });
  }
}

class ItemPemanduWisata extends StatelessWidget {
  final PemanduWisata pemanduWisata;
  const ItemPemanduWisata({Key? key, required this.pemanduWisata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 220, 220, 220),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: Text(
            pemanduWisata.guide!,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Georgia',
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            "Rating: ${pemanduWisata.rating}",
            style: const TextStyle(
              color: Color.fromARGB(255, 80, 80, 80),
              fontFamily: 'Georgia',
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PemanduWisataDetail(
                          pemanduWisata: pemanduWisata,
                        )));
          },
        ),
      ),
    );
  }
}
