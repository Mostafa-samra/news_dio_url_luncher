import 'package:flutter/material.dart';
import 'package:myexame/models/newsresponse.dart';
import 'package:myexame/service/new_services_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("News App"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tesla",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
            ),
            Text(
              "The News App From Descoverd",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: FutureBuilder<List<Article?>?>(
                  future: NewsApiService().getNewsArticales(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<Article?> newsArticle = snapshot.data!;
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Newstile(
                            article: newsArticle[index]!,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class Newstile extends StatelessWidget {
  final Article article;

  const Newstile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListTile(
        onTap: () async {
          await canLaunchUrlString(article.url)
              ? await launchUrlString(article.url)
              : throw 'Could not launch ${article.url}';
        },
        title: Text(
          article.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: Text(
          article.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: article.urlToImage != null
            ? Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage("${article.urlToImage}"),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
