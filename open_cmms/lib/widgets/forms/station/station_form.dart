import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../snacbars.dart';

class StationForm extends StatefulWidget implements hasFormTitle {
  final RoadSegmentSchema roadSegment;

  const StationForm(this.roadSegment, {Key? key}) : super(key: key);

  @override
  String getTitle() {
    return "Vytvorit stanicu";
  }

  @override
  StationForm getInstance() {
    return this;
  }

  @override
  State<StationForm> createState() => _StationFormState();
}

class _StationFormState extends State<StationForm> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String kmNote = "";
  num? km;
  num? lon;
  num? lat;
  int? seeLevel;
  String note = '';

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (value) {
                name = value!;
              },
              decoration: const InputDecoration(labelText: 'meno'),
              validator: (value) {
                return value == null || value.isEmpty ? "zvolete meno" : null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                km = num.tryParse(value!);
              },
              decoration:
                  const InputDecoration(labelText: 'kilometer cestneho useku'),
              validator: (value) {
                return value != '' && num.tryParse(value ?? "") == null
                    ? "zadali ste zly format, zadajte cislo s destinou botkou"
                    : null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                kmNote = value ?? "";
              },
              decoration: const InputDecoration(
                  labelText: 'kilometer cestneho useku poznamka'),
            ),
            TextFormField(
              onSaved: (value) {
                lat = num.tryParse(value!);
              },
              decoration:
                  const InputDecoration(labelText: 'gps - sirka (47-49)'),
              validator: (value) {
                return value != '' && num.tryParse(value ?? "") == null
                    ? "zadali ste zly format, zadajte cislo s destinou botkou"
                    : null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                lon = num.tryParse(value!);
              },
              decoration:
                  const InputDecoration(labelText: 'gps - dlzka (16-22)'),
              validator: (value) {
                return value != '' && num.tryParse(value ?? "") == null
                    ? "zadali ste zly format, zadajte cislo s destinou botkou"
                    : null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                seeLevel = int.tryParse(value!);
              },
              decoration: const InputDecoration(labelText: 'nadmorska vyska'),
              validator: (value) {
                return value != '' && int.tryParse(value ?? "") == null
                    ? "zadali ste zly format, zadajte cele cislo "
                    : null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                note = value ?? '';
              },
              decoration: const InputDecoration(labelText: 'poznamka'),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("spat")),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        StationService()
                            .createStationStationCreateStationPost(
                                StationNewSchema(
                                    name: name,
                                    roadSegmentId: widget.roadSegment.id,
                                    kmOfRoad: km,
                                    kmOfRoadNote: kmNote,
                                    latitude: lat,
                                    longitude: lon,
                                    seeLevel: seeLevel,
                                    description: note))
                            .then((value) {
                          Get.back();
                          showOk("stanica: $name bola vytvorena");
                        });
                      }
                    },
                    child: const Text("vytvorit")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
