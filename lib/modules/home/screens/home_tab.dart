import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/home/provider/home_provider.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider.notifier);
    ref.watch(homeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Bikes Summary', style: TextStyle(fontSize: 20)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: MapboxMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(24.7123, 46.6727),
                zoom: 14,
              ),
              accessToken:
                  'pk.eyJ1IjoiYmVzaG95YmUiLCJhIjoiY2xodHF2OWMzMGpxZDNrbzFjNGhxanlxbyJ9.tDbg5LbuZiNGhKpowLznQg',
              onMapCreated: provider.onMapCreated,
              onStyleLoadedCallback: provider.onMapLoaded,
            ),
          ),
        ),
      ],
    );
  }
}
