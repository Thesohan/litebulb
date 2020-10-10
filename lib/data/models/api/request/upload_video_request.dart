import 'dart:io';

class UploadVideoRequest {
  final String title;
  final String category;
  final String video_id;
  final String description;
  final String tags;
  final String is_safe;
  final String is_public;
  final String id;
  final File files;
  final File thumbnail;

  UploadVideoRequest({
    this.title,
    this.category,
    this.video_id,
    this.description,
    this.tags,
    this.is_safe,
    this.is_public,
    this.id,
    this.files,
    this.thumbnail,
  });

  @override
  String toString() {
    return 'UploadVideoReqest{title$title,'
        'category:$category,'
        'video_id:$video_id,'
        'description:$description,'
        'tags:$tags,'
        'is_safe:$is_safe,'
        'is_public:$is_public,'
        'id:$id,'
        'files:$files';
  }
}
