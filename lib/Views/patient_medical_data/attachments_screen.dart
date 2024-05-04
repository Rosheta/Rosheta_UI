import "dart:typed_data";
import "package:flutter/material.dart";
import 'package:rosheta_ui/drawer/drawers.dart';
import "package:rosheta_ui/components/shared/appbar.dart";
import "package:rosheta_ui/Views/patient_medical_data/show_file_screen.dart";
import "package:rosheta_ui/models/patient_medical_data/attachment_model.dart";
import "package:rosheta_ui/services/patient_medical_data/attachment_service.dart";

class AttachmentScreen extends StatefulWidget {
  const AttachmentScreen({super.key});

  @override
  _AttachmentScreenState createState() => _AttachmentScreenState();
}

class _AttachmentScreenState extends State<AttachmentScreen> {
  late Future<List<Attachment>> attachments;

  @override
  void initState() {
    super.initState();
    attachments = _fetchAttachments();
  }

  Future<List<Attachment>> _fetchAttachments() async {
    try {
      AttachmentApi attachmentApi = AttachmentApi();
      return await attachmentApi.getAttachments();
    } catch (e) {
      throw Exception('Failed to fetch attachments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      drawer: select_drawer(context),
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
                        index: index,
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
    required int index,
    required BuildContext context,
  }) {
    IconData iconData;
    switch (ext.toLowerCase()) {
      case '.pdf':
        iconData = Icons.picture_as_pdf;
        break;
      case '.png':
      case '.jpeg':
      case '.jpg':
        iconData = Icons.image;
        break;
      default:
        iconData = Icons.insert_drive_file;
        break;
    }

    return InkWell(
      onTap: () async {
        AttachmentApi attachmentApi = AttachmentApi();
        Uint8List tmp = await attachmentApi.getAttachment(fileHash);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowFileScreen(serverData: tmp , ext: ext)),
        );
      },
      child: Card(
        child: ListTile(
          leading: Icon(iconData),
          title: Text(
            '$name$ext',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ), 
          subtitle: Text(time),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed:  () async {
              AttachmentApi attachmentApi = AttachmentApi();
              bool check = await attachmentApi.deleteAttachment(fileHash);
              if (check) {
                setState(() {
                  attachments = attachments.then((attachmentList) {
                    attachmentList.removeAt(index);
                    return attachmentList;
                  });
                });
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
