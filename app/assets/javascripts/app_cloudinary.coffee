$ ->

  if $('#profile_widget_opener').length
    cloudinary.applyUploadWidget document.getElementById('profile_widget_opener'), {
      cloudName: 'dns0hx43q'
      uploadPreset: 'PRESET'
      fieldName: 'profile[profile_image]'
      sources: [ 'local', 'camera']
      showSkipCropButton: false
      cropping: 'server'
      croppingAspectRatio: 1.25
      croppingShowDimensions: true
      croppingCoordinatesMode: 'custom'
      eager: 'custom'
      secure: true
      multiple: false
    }, (error, result) ->
      console.log error, result
      return
