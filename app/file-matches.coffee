
module.exports =

  'video-extensions': [
    'avi'
    'flv'
    'm1v'
    'm2v'
    'm4v'
    'mkv'
    'mov'
    'mpeg'
    'mpg'
    'mpe'
    'mp4'
    'ogg'
    'wmv'
  ]

  patterns:
    TVShow: [
      /^(.*)\[(.*)\]\[cap.(\d{3})\]\[(.*)\]/i
    ]
    Movie: [
      /^(.*)\[(.*)\]\[(.*)\]\[(.*)\]\[(.*)\]/i
      /^(.*)\[(.*)\]\[(.*)\]\[(.*)\]/i
    ]

