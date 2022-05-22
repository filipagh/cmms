from http.server import HTTPServer, SimpleHTTPRequestHandler


class xxxxx(SimpleHTTPRequestHandler):

    def do_GET(self):
        path = self.translate_path(self.path)
        f = None
        try:
            f = open(path, 'rb')
        except OSError:
            self.path = '/'
            ff = self.send_head()
            self.copyfile(ff, self.wfile)
            ff.close()
            return
        finally:
            if f:
                f.close()

        f = self.send_head()
        if f:
            try:
                self.copyfile(f, self.wfile)
            finally:
                f.close()


def run(server_class=HTTPServer, handler_class=xxxxx):
    server_address = ('0.0.0.0', 22222)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()


run()
