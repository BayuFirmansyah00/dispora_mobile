import 'dart:convert';
import 'package:ekraf_kuy/config/config.dart';
import 'package:ekraf_kuy/presentation/informasi_event_screen/informasi_event_screen.dart';
import 'package:ekraf_kuy/presentation/informasi_event_screen/informasi_article_screen.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../core/app_export.dart';
import 'widgets/eventlist_item_widget.dart';
import '../../../models/Event.dart';
import '../../../models/Article.dart';
import '../../services/api_service.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Event> events = [];
  List<Article> articles = [];
  bool _showEvents = true;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Ambil data event
      List<Event> tempEvents = [];
      try {
        final result = await ApiService.get(Config.eventsEndpoint);
        print('Raw API Response (Events): ${jsonEncode(result)}');

        List<dynamic> rawList = [];
        if (result is Map<String, dynamic>) {
          if (result['data'] is Map && result['data']['data'] is List) {
            rawList = result['data']['data'] as List<dynamic>;
          } else if (result['events'] is List) {
            rawList = result['events'] as List<dynamic>;
          }
        } else if (result is List) {
          rawList = result;
        }

        tempEvents = rawList
            .map((item) {
              print('Parsing Event JSON: $item');
              return Event.fromJson(item as Map<String, dynamic>);
            })
            .toList();
      } catch (e) {
        print('Error fetching events: $e');
        throw Exception('Gagal memuat events: $e');
      }

      // Ambil data artikel
      List<Article> tempArticles = [];
      try {
        final articlesEndpoint = Config.articlesEndpoint ?? 'api/articles';
        print('Mengakses endpoint artikel: $articlesEndpoint');
        final result = await ApiService.get(articlesEndpoint);
        print('Raw API Response (Articles): ${jsonEncode(result)}');

        List<dynamic> rawList = [];
        if (result is Map<String, dynamic>) {
          if (result['data'] is Map && result['data']['data'] is List) {
            rawList = result['data']['data'] as List<dynamic>;
          } else if (result['articles'] is List) {
            rawList = result['articles'] as List<dynamic>;
          }
        } else if (result is List) {
          rawList = result;
        }

        tempArticles = rawList
            .map((item) {
              print('Parsing Article JSON: $item');
              return Article.fromJson(item as Map<String, dynamic>);
            })
            .toList();
      } catch (e) {
        print('Error fetching articles: $e');
        print('Status kode atau respons untuk api/articles: ${e.toString().contains('404') ? '404 Not Found' : e}');
        tempArticles = [];
        print('Mengabaikan error articles, melanjutkan dengan events');
      }

      setState(() {
        events = tempEvents;
        articles = tempArticles;
        print('Events loaded: ${events.length}');
        print('Articles loaded: ${articles.length}');
        if (events.isNotEmpty) {
          print('Event[0]: ${events[0].toString()}');
          print('Event[0] formattedCreatedAt: ${events[0].formattedCreatedAt}');
        }
        if (articles.isNotEmpty) {
          print('Article[0]: ${articles[0].toString()}');
          print('Article[0] formattedCreatedAt: ${articles[0].formattedCreatedAt}');
        }
        isLoading = false;
        if (tempArticles.isEmpty) {
          errorMessage = 'Endpoint artikel tidak ditemukan atau kosong. Hanya events dimuat.';
        }
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Gagal memuat data: $e';
        if (e.toString().contains('404')) {
          errorMessage = 'Endpoint "api/events" tidak ditemukan (404). Periksa server atau URL API.';
        } else if (e.toString().contains('No valid list found')) {
          errorMessage = 'Struktur data API tidak valid. Daftar event tidak ditemukan di respons API.';
        }
      });
    }
  }

  Future<void> _handleRefresh() async {
    await fetchData();
  }

  Widget _buildToggleBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _showEvents = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _showEvents ? Color(0xFF123458) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Event',
                    style: TextStyle(
                      color: _showEvents ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _showEvents = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_showEvents ? Color(0xFF123458) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Artikel',
                    style: TextStyle(
                      color: !_showEvents ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildToggleBar(),
            Expanded(
              child: LiquidPullToRefresh(
                onRefresh: _handleRefresh,
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : errorMessage != null && events.isEmpty && articles.isEmpty
                        ? Center(child: Text(errorMessage!))
                        : (_showEvents ? events.isEmpty : articles.isEmpty)
                            ? Center(child: Text(_showEvents ? 'Tidak ada event' : 'Tidak ada artikel'))
                            : ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                itemCount: _showEvents ? events.length : articles.length,
                                separatorBuilder: (_, __) => SizedBox(height: 14),
                                itemBuilder: (context, index) {
                                  if (_showEvents) {
                                    final event = events[index];
                                    if (event is! Event) {
                                      print('Unexpected type in events list: ${event.runtimeType}');
                                      return SizedBox.shrink();
                                    }
                                    return EventlistItemWidget(
                                      title: event.title,
                                      imageUrl: event.thumbnail,
                                      createdAt: event.formattedCreatedAt,
                                      onTapColumnSelengkap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => InformasiEventScreen(
                                              data: event,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    final article = articles[index];
                                    if (article is! Article) {
                                      print('Unexpected type in articles list: ${article.runtimeType}');
                                      return SizedBox.shrink();
                                    }
                                    return EventlistItemWidget(
                                      title: article.title,
                                      imageUrl: article.thumbnail,
                                      createdAt: article.formattedCreatedAt,
                                      onTapColumnSelengkap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => InformasiArticleScreen(
                                              data: article,
                                            ),
                                          ),
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
      ),
    );
  }
}