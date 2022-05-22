from http.server import HTTPServer, SimpleHTTPRequestHandler


class xxxxx(SimpleHTTPRequestHandler):

    def do_GET(self):
        f = self.send_head()
        if f:
            try:
                self.copyfile(f, self.wfile)
            except:
                self.path = '/'
                f = self.send_head()
                self.copyfile(f, self.wfile)
            finally:
                f.close()
                return

        self.path = '/'
        f = self.send_head()
        self.copyfile(f, self.wfile)



def run(server_class=HTTPServer, handler_class=xxxxx):
    server_address = ('0.0.0.0', 22222)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()


run()
