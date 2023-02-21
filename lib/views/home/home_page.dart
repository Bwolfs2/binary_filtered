import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var days = 0;

  var selectedWeeks = [
    ...data
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You Food'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: DayType.values
                  .map((e) => Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              days ^= e.value;
                              selectedWeeks = data.where((element) => ((element['scheduled'] as int) & days) == days).toList();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(color: (days & e.value) == e.value ? Colors.red : Colors.green, borderRadius: BorderRadius.circular(32), boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]),
                            child: Text(
                              e.name.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Text(days.toString()),
          Expanded(
            child: ListView.builder(
              itemCount: selectedWeeks.length,
              itemBuilder: (context, index) => ListTile(
                title: Text('${selectedWeeks[index]['name']}'),
                subtitle: Wrap(
                  children: DayType.values
                      .where((element) => ((selectedWeeks[index]['scheduled'] as int) & element.value) == element.value)
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum DayType {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  static int get weekend => saturday.value | sunday.value;

  int get value => 1 << index;
}

var data = List.generate(100, (index) {
  if (index % 5 == 0) {
    return {
      'id': index,
      'name': 'Semana $index',
      'scheduled': DayType.monday.value | DayType.tuesday.value | DayType.wednesday.value,
    };
  }

  if (index % 3 == 0) {
    return {
      'id': index,
      'name': 'Semana $index',
      'scheduled': DayType.weekend,
    };
  }

  if (index % 2 == 0) {
    return {
      'id': index,
      'name': 'Semana $index',
      'scheduled': DayType.wednesday.value,
    };
  }

  return {
    'id': index,
    'name': 'Semana $index',
    'scheduled': DayType.monday.value,
  };
});
