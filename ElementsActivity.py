from sugar.activity import activity
from sugar import env
import os
import gtk
import gobject
import hulahop
hulahop.startup(os.path.join(env.get_profile_path(), 'gecko'))
from XOCom import XOCom

class ElementsActivity (activity.Activity):
    def __init__(self, handle):
        activity.Activity.__init__(self, handle)
        self.set_title('Elements')

        act_root = self.get_activity_root()
        path_data = os.path.join(act_root, "data")
        self.file_name = os.path.join(path_data,"datos.js")
        # The XOCom object helps us communicate with the browser
        # This uses web/index.html as the default page to load
        self.xocom = XOCom("file://"+os.path.join(os.path.dirname(os.path.abspath(__file__)),"web/allelements.xml"))

        toolbox = activity.ActivityToolbox(self)
        self.set_toolbox(toolbox)
        toolbox.show()

        self.set_canvas( self.xocom.create_webview() )
        
        self.read_file(self.file_name)


    def write_file(self, filename):
        print "Grabando", filename
        content = self.xocom.send_to_browser('write')

        if content:
            fh = open(filename, 'w')
            fh.write(content)
            fh.close()

    def read_file(self, filename):
        print "Leyendo", filename
        content = "textos = new Array();"
        if os.path.exists(filename):
            fh = open(filename, 'r')
            content = fh.read()
            print content
        def send_delayed_read():
            self.xocom.send_to_browser('read', content)
            return False
        # We must delay this to give the browser time to start up
        # It would be better if this send_to_browser was instead triggered
        # once the browser had finished loading.
        gobject.timeout_add(5000, send_delayed_read)
