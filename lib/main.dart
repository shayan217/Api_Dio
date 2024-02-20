import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await Dio().get("http://dealsabaad.com:5001/deal/get/3");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Deal Details'),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final data = snapshot.data!;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deal Name: ${data['name']}',
                      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Deal Description: ${data['desc']}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Inventory Details:',
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    for (var inventoryItem in data['DealInventory'])
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Inventory ID: ${inventoryItem['inventoryId']}',
                            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Name: ${inventoryItem['inventory']['unitno']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Description: ${inventoryItem['inventory']['sizestype']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Price: ${inventoryItem['inventory']['saleprice']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Start Date: ${inventoryItem['inventory']['createdAt']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'End Date: ${inventoryItem['inventory']['updatedAt']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Floor Plan: ${inventoryItem['inventory']['floorId']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'User ID: ${inventoryItem['inventory']['userId']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Referral: ${inventoryItem['inventory']['referral']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Status: ${inventoryItem['inventory']['status']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Deleted: ${inventoryItem['inventory']['deleted']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Created At: ${inventoryItem['inventory']['createdAt']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Updated At: ${inventoryItem['inventory']['updatedAt']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
