import "package:flutter/material.dart";
import "package:rosheta_ui/Views/chat/friends_screen.dart";
import "package:rosheta_ui/Views/patient_medical_data/show_file_screen.dart";
import "package:rosheta_ui/Views/search/search_screen.dart";
import "package:rosheta_ui/generated/l10n.dart";
import "package:rosheta_ui/models/patient_medical_data/attachment_model.dart";
import "package:rosheta_ui/services/patient_medical_data/attachment_service.dart";

class AttachmentScreen extends StatelessWidget {
  late Future<List<Attachment>> attachments;

  AttachmentScreen({super.key});

  Future<List<Attachment>> _fetchattachments() async {
    try {
      AttachmentApi attachmentApi = AttachmentApi();
      return await attachmentApi.getAttachments();
    } catch (e) {
      throw Exception('Failed to fetch profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    attachments = _fetchattachments();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          S.of(context).title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.message),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const FriendsScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: SearchPeople());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Attachment>>(
        future: attachments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return dumy(context);
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Attachment> pr = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => fileCard(
                        fileHash: pr[index].fileHash!,
                        name: pr[index].name!,
                        ext: pr[index].ext!,
                        time: pr[index].time!,
                        context: context,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20.0,
                      ),
                      itemCount: pr.length,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget fileCard({
    required String fileHash,
    required String name,
    required String ext,
    required String time,
    required BuildContext context,
  }) {
    // Determine icon based on file extension
    IconData iconData;
    switch (ext.toLowerCase()) {
      case 'pdf':
        iconData = Icons.picture_as_pdf;
        break;
      case 'doc':
      case 'docx':
        iconData = Icons.description;
        break;
      case 'txt':
        iconData = Icons.article;
        break;
      // Add more cases for different file types as needed
      default:
        iconData = Icons.insert_drive_file;
        break;
    }

    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowFileScreen()),
          );
        },
        child: Card(
        child: ListTile(
          leading: Icon(iconData),
          title: Text(
            '$name.$ext',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ), // Show file name with extension
          subtitle: Text(time), // Show upload time
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              AttachmentApi attachmentApi = AttachmentApi();
              bool check = await attachmentApi.deleteAttachment(fileHash);
              if (check) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('File deleted successfully'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to delete file'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
