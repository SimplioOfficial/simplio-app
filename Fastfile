lane :beta do
  sync_code_signing(type: "appstore")    # see code signing guide for more information
  build_app(scheme: "MyApp")
  upload_to_testflight
  slack(message: "Successfully distributed a new beta build")
end
