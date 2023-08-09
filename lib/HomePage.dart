import 'dart:js_interop';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Add text controllers for each field
  GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  String _selectedSubject = 'biology';
  String _selectedClass = 'class9th';
  String _selectedClassTab2 = 'class9th';
  String _selectedClassTab3 = 'class9th';
  String _selectedSubjectTab2 = 'biology';
  bool _isLoading = false;
  String _selectedChapter = 'chapter-01';
  String _selectedChapterTab2 = 'chapter-01';
  List<String> _chapterOptions = List<String>.generate(30, (index) {
    // Adding leading zeros to the index
    String paddedIndex = (index + 1).toString().padLeft(2, '0');
    return 'chapter-$paddedIndex';
  });

  List<String> _chapterDescriptionTab2 = List<String>.generate(30, (index) {
    // Adding leading zeros to the index
    String paddedIndex = (index + 1).toString().padLeft(2, '0');
    return 'Chapter $paddedIndex';
  });


  String selectedDescription = "Chapter 1";
  String _selectedTopic = 'topic01';
  String _selectedTopicTab3 = 'topic01';
  final List<String> _topicOptions = List<String>.generate(30, (index) {
    // Adding leading zeros to the index
    String paddedIndex = (index + 1).toString().padLeft(2, '0');
    return 'topic$paddedIndex';
  });

  String _selectedQuestion = 'question-1';
  List<String> _questionOptions =
  List<String>.generate(10, (index) => 'question-${index + 1}');

  TextEditingController _questionController = TextEditingController();
  TextEditingController _topicNameController = TextEditingController();
  TextEditingController _youtubeIDController = TextEditingController();
  TextEditingController _chapterNameController = TextEditingController();
  TextEditingController _chapterIconController = TextEditingController();
  TextEditingController _correctOptionController = TextEditingController();
  TextEditingController _optionAController = TextEditingController();
  TextEditingController _optionBController = TextEditingController();
  TextEditingController _optionCController = TextEditingController();
  TextEditingController _optionDController = TextEditingController();

  int _selectedIndex = 0;
  TextEditingController _textInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // fetchQuestionAndCorrectOption();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Superior Data Uploading'),
      ),
      body: Row(
        children: [
          Container(
            width: 200,
            color: Colors.grey[200],
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Enter MCQS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _selectedIndex == 0 ? Colors.blue : null,
                    ),
                  ),
                  tileColor: _selectedIndex == 0 ? Colors.blue[100] : null,
                  onTap: () {
                    _selectTab(0);
                  },
                ),
                ListTile(
                  title: Text(
                    'Update Chapters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _selectedIndex == 1 ? Colors.blue : null,
                    ),
                  ),
                  tileColor: _selectedIndex == 1 ? Colors.blue[100] : null,
                  onTap: () {
                    _selectTab(1);
                  },
                ),
                ListTile(
                  title: Text(
                    'Update Topics',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _selectedIndex == 2 ? Colors.blue : null,
                    ),
                  ),
                  tileColor: _selectedIndex == 2 ? Colors.blue[100] : null,
                  onTap: () {
                    _selectTab(2);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(1),
                  child: Image.asset(
                    'assets/images/logo.png',
                    // Replace with your logo asset path
                    width: 90,
                    height: 90,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _isLoading
                          ? Center(
                          child:
                          CircularProgressIndicator()) // Show the circular progress indicator if loading
                          : ListView(
                        padding: EdgeInsets.all(16),
                        children: [
                          // Center(child: Text('Content for Tab 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                          // SizedBox(height: 20),
                          Form(
                            key: _formKey1,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child:
                                      DropdownButtonFormField<String>(
                                        value: _selectedClass,
                                        items: [
                                          DropdownMenuItem(
                                              value: 'class9th',
                                              child: Text('Class 9th')),
                                          DropdownMenuItem(
                                              value: 'class10th',
                                              child: Text('Class 10th')),
                                          DropdownMenuItem(
                                              value: 'class11th',
                                              child: Text('Class 11th')),
                                          DropdownMenuItem(
                                              value: 'class12th',
                                              child: Text('Class 12th')),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedClass = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Class',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child:
                                      DropdownButtonFormField<String>(
                                        value: _selectedSubject,
                                        items: [
                                          DropdownMenuItem(
                                              value: 'biology',
                                              child: Text('Biology')),
                                          DropdownMenuItem(
                                              value: 'physics',
                                              child: Text('Physics')),
                                          DropdownMenuItem(
                                              value: 'math',
                                              child: Text('Math')),
                                          DropdownMenuItem(
                                              value: 'chemistry',
                                              child: Text('Chemistry')),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedSubject = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Subject',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: DropdownButtonFormField(
                                        value: _selectedChapter,
                                        items: _chapterOptions
                                            .map((String chapter) {
                                          return DropdownMenuItem<String>(
                                            value: chapter,
                                            child: Text(chapter),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedChapter = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Chapter',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField(
                                        value: _selectedTopic,
                                        items: _topicOptions
                                            .map((String topic) {
                                          return DropdownMenuItem<String>(
                                            value: topic,
                                            child: Text(topic),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedTopic = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Topic',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: DropdownButtonFormField(
                                        value: _selectedQuestion,
                                        items: _questionOptions
                                            .map((String question) {
                                          return DropdownMenuItem<String>(
                                            value: question,
                                            child: Text(question),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedQuestion = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Question number',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _questionController,
                                  decoration: InputDecoration(
                                    labelText: 'Question',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Question is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _optionAController,
                                        decoration: InputDecoration(
                                          labelText: 'Option A',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Option A is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _optionBController,
                                        decoration: InputDecoration(
                                          labelText: 'Option B',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Option B is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _optionCController,
                                        decoration: InputDecoration(
                                          labelText: 'Option C',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Option C is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _optionDController,
                                        decoration: InputDecoration(
                                          labelText: 'Option D',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Option D is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _correctOptionController,
                                  decoration: InputDecoration(
                                    labelText: 'Correct Option',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Correct Option is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey1.currentState!.validate()) {
                                uploadData(
                                  _questionController.text,
                                  _correctOptionController.text,
                                  _optionAController.text,
                                  _optionBController.text,
                                  _optionCController.text,
                                  _optionDController.text,
                                );
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(
                                  double.infinity,
                                  50)), // Set the desired height
                            ),
                            child: Text('Upload'),
                          ),
                        ],
                      ),
                      _isLoading //tab 2 here
                          ? Center(
                          child:
                          CircularProgressIndicator()) // Show the circular progress indicator if loading
                          : ListView(
                        padding: EdgeInsets.all(16),
                        children: [
                          // Center(child: Text('Content for Tab 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                          // SizedBox(height: 20),
                          Form(
                            key: _formKey2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child:
                                      DropdownButtonFormField<String>(
                                        value: _selectedClassTab2,
                                        items: [
                                          DropdownMenuItem(
                                              value: 'class9th',
                                              child: Text('Class 9th')),
                                          DropdownMenuItem(
                                              value: 'class10th',
                                              child: Text('Class 10th')),
                                          DropdownMenuItem(
                                              value: 'class11th',
                                              child: Text('Class 11th')),
                                          DropdownMenuItem(
                                              value: 'class12th',
                                              child: Text('Class 12th')),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedClassTab2 = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Class',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child:
                                      DropdownButtonFormField<String>(
                                        value: _selectedSubjectTab2,
                                        items: [
                                          DropdownMenuItem(
                                              value: 'biology',
                                              child: Text('Biology')),
                                          DropdownMenuItem(
                                              value: 'subjects-1',
                                              child: Text('Physics')),
                                          DropdownMenuItem(
                                              value: 'math',
                                              child: Text('Math')),
                                          DropdownMenuItem(
                                              value: 'chemistry',
                                              child: Text('Chemistry')),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedSubjectTab2 = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Subject',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: DropdownButtonFormField(
                                        value: _selectedChapterTab2,
                                        items: _chapterOptions
                                            .map((String chapter) {
                                          return DropdownMenuItem<String>(
                                            value: chapter,
                                            child: Text(chapter),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedChapterTab2 = value!;
                                            int selectedIndex =
                                            _chapterOptions
                                                .indexOf(value);
                                            selectedDescription =
                                            _chapterDescriptionTab2[
                                            selectedIndex];
                                            print(selectedDescription);
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Chapter',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _chapterNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),

                                TextFormField(
                                  controller: _chapterIconController,
                                  decoration: InputDecoration(
                                    labelText: 'Icon',
                                    border: OutlineInputBorder(),
                                  ),
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Name is required';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey2.currentState!.validate()) {
                                uploadChapterData(
                                  _chapterNameController.text,
                                );
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(
                                  double.infinity,
                                  50)), // Set the desired height
                            ),
                            child: Text('Upload'),
                          ),
                        ],
                      ),
                      _isLoading //tab 3 here
                          ? Center(
                          child:
                          CircularProgressIndicator()) // Show the circular progress indicator if loading
                          : ListView(
                        padding: EdgeInsets.all(16),
                        children: [
                          // Center(child: Text('Content for Tab 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                          // SizedBox(height: 20),
                          Form(
                            key: _formKey3,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child:
                                      DropdownButtonFormField<String>(
                                        value: _selectedClassTab3,
                                        items: [
                                          DropdownMenuItem(
                                              value: 'class9th',
                                              child: Text('Class 9th')),
                                          DropdownMenuItem(
                                              value: 'class10th',
                                              child: Text('Class 10th')),
                                          DropdownMenuItem(
                                              value: 'class11th',
                                              child: Text('Class 11th')),
                                          DropdownMenuItem(
                                              value: 'class12th',
                                              child: Text('Class 12th')),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedClassTab3 = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Class',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child:
                                      DropdownButtonFormField<String>(
                                        value: _selectedSubjectTab2,
                                        items: [
                                          DropdownMenuItem(
                                              value: 'biology',
                                              child: Text('Biology')),
                                          DropdownMenuItem(
                                              value: 'subjects-1',
                                              child: Text('Physics')),
                                          DropdownMenuItem(
                                              value: 'math',
                                              child: Text('Math')),
                                          DropdownMenuItem(
                                              value: 'chemistry',
                                              child: Text('Chemistry')),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedSubjectTab2 = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Subject',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: DropdownButtonFormField(
                                        value: _selectedChapterTab2,
                                        items: _chapterOptions
                                            .map((String chapter) {
                                          return DropdownMenuItem<String>(
                                            value: chapter,
                                            child: Text(chapter),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedChapterTab2 = value!;
                                            int selectedIndex =
                                            _chapterOptions
                                                .indexOf(value);
                                            selectedDescription =
                                            _chapterDescriptionTab2[
                                            selectedIndex];
                                            print(selectedDescription);
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Chapter',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),


                                DropdownButtonFormField(
                                  value: _selectedTopicTab3,
                                  items: _topicOptions
                                      .map((String topic) {
                                    return DropdownMenuItem<String>(
                                      value: topic,
                                      child: Text(topic),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedTopicTab3 = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Topic',
                                    border: OutlineInputBorder(),
                                  ),
                                ),

                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _topicNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name is required';
                                    }
                                    return null;
                                  },
                                ), SizedBox(height: 10),
                                TextFormField(
                                  controller: _youtubeIDController,
                                  decoration: InputDecoration(
                                    labelText: 'Youtube ID',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'ID is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey3.currentState!.validate()) {
                                uploadChapterTopicsData(
                                    _topicNameController.text,
                                    _youtubeIDController.text
                                );
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(
                                  double.infinity,
                                  50)), // Set the desired height
                            ),
                            child: Text('Upload'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void uploadData(String question, String correctOption, String optionA,
      String optionB, String optionC, String optionD) {
    // Create a reference to the Firebase database here 2
    setState(() {
      _isLoading = true;
    });
    DatabaseReference reference = FirebaseDatabase.instance.reference();

    // Check if any field is empty
    if (question.isEmpty ||
        correctOption.isEmpty ||
        optionA.isEmpty ||
        optionB.isEmpty ||
        optionC.isEmpty ||
        optionD.isEmpty) {
      // Display error message for empty fields
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('All fields are required.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    RegExp regExp = RegExp(r'(\d+)');
    Match? match = regExp.firstMatch(_selectedQuestion);
    String mcqID = "0";
    if (match != null) {
      mcqID = match.group(0)!;
      print(mcqID);
    } else {
      print("Chapter number not found");
    }

    // Build the data to be uploaded
    Map<String, dynamic> data = {
      'question': question,
      'correctOption': correctOption,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'id': int.parse(mcqID),
    };

    // Upload the data to the same path
    reference
        .child('contents')
        .child('topic_questions')
        .child(_selectedClass)
        .child('subjects')
        .child(_selectedSubject)
        .child(_selectedChapter)
        .child(_selectedTopic)
        .child(_selectedQuestion)
        .update(data)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data updated successfully"),
      ));

      setState(() {
        _isLoading = false;
        _questionController.clear();
        _correctOptionController.clear();
        _optionAController.clear();
        _optionBController.clear();
        _optionCController.clear();
        _optionDController.clear();
      });
      print('Data uploaded successfully');
      // Show success message or perform any other actions
    }).catchError((error) {
      print('Failed to upload data: $error');
      // Show error message or perform any other error handling
    });
  }

  void uploadChapterData(String chapterName) {
    // tab 2 fun
    // Create a reference to the Firebase database here 2
    setState(() {
      _isLoading = true;
    });
    DatabaseReference reference = FirebaseDatabase.instance.reference();

    // Check if any field is empty
    if (chapterName.isEmpty) {
      // Display error message for empty fields
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('All fields are required.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    RegExp regExp = RegExp(r'(\d+)');
    Match? match = regExp.firstMatch(selectedDescription);
    String chapterID = "0";
    if (match != null) {
      chapterID = match.group(0)!;
      print(chapterID);
    } else {
      print("Chapter number not found");
    }

    // Build the data to be uploaded
    var icon = "https://firebasestorage.googleapis.com/v0/b/exambites-application.appspot.com/o/chapterIcons%2Fbiology%2FB1.%20Introduction%20to%20biology.png?alt=media&token=bfa5cc0c-6bf6-426f-b428-fb55b564fa84";

    if(_chapterIconController.text.isNotEmpty){
      icon=convertToDownloadLink(_chapterIconController.text);
 //   icon=_chapterIconController.text;
 //    icon='https://drive.google.com/uc?export=download&id=${_chapterIconController.text}';
    }

    Map<String, dynamic> data = {
    'description': selectedDescription,
    'icon':icon,
    'name': chapterName,
    'totalVideos': "10",
    'id': chapterID,
    };

    // Upload the data to the same path
    reference
        .child('contents')
        .child('books')
        .child(_selectedClassTab2)
        .child(_selectedSubjectTab2)
        .child(_selectedChapterTab2)
        .update(data)
        .then((_) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Data updated successfully"),
    ));

    setState(() {
    _isLoading = false;
    _chapterNameController.clear();
    _chapterIconController.clear();
    });
    print('Data uploaded successfully');
    // Show success message or perform any other actions
    }).catchError((error) {
    print('Failed to upload data: $error');
    // Show error message or perform any other error handling
    });
  }

  void uploadChapterTopicsData(String topicName, String youtubeId) {
    // tab 3 fun
    // Create a reference to the Firebase database here 2
    setState(() {
      _isLoading = true;
    });
    DatabaseReference reference = FirebaseDatabase.instance.reference();

    // Check if any field is empty
    if (topicName.isEmpty || youtubeId.isEmpty) {
      // Display error message for empty fields
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('All fields are required.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    RegExp regExp = RegExp(r'(\d+)');
    Match? match = regExp.firstMatch(selectedDescription);
    String chapterID = "0";
    if (match != null) {
      chapterID = match.group(0)!;
      print(chapterID);
    } else {
      print("Chapter number not found");
    }

    // Build the data to be uploaded
    Map<String, dynamic> data = {
      'engUrlDownload': "",
      'urduUrlDownload': "",
      'name': topicName,
      'urlEng': youtubeId,
      'urlUrdu': "",
      'watch': "",

    };

    // Upload the data to the same path
    reference
        .child('contents')
        .child('books')
        .child(_selectedClassTab3)
        .child(_selectedSubjectTab2)
        .child(_selectedChapterTab2)
        .child('topics')
        .child(_selectedTopicTab3)
        .update(data)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data updated successfully"),
      ));

      setState(() {
        _isLoading = false;


        _topicNameController.clear();
        _youtubeIDController.clear();
      });
      print('Data uploaded successfully');
      // Show success message or perform any other actions
    }).catchError((error) {
      print('Failed to upload data: $error');
      // Show error message or perform any other error handling
    });
  }

  String convertToDownloadLink(String viewLink) {
    // Check if the input link contains the expected format
    if (!viewLink.contains('/file/d/') || !viewLink.contains('/view?usp=sharing')) {
      throw ArgumentError("Invalid input link format. It should be a Google Drive view link.");
    }

    // Extract the file ID from the original link
    final fileIdStartIndex = viewLink.indexOf('/file/d/') + '/file/d/'.length;
    final fileIdEndIndex = viewLink.indexOf('/view?usp=sharing');
    final fileId = viewLink.substring(fileIdStartIndex, fileIdEndIndex);

    // Construct the new download link
    final downloadLink = 'https://drive.google.com/uc?export=download&id=$fileId';

    return downloadLink;
  }

}
