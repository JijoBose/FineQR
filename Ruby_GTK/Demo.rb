require "gtk3"
require 'rqrcode'
require 'launchy'


class FineQRApp < Gtk::Window

    def initialize
        super

        init_ui
    end

    def init_ui

        set_title "FineQR - Generate QR Code"
        signal_connect "destroy" do
            Gtk.main_quit
        end

        set_default_size 800, 600
        set_window_position :center

        stack = Gtk::Stack.new
        stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT)
        stack.set_transition_duration(1000)

        label_entry = Gtk::Label.new "Enter your content"
        stack.add_titled(label_entry)

        show_all
    end

    def on_clicked
        about = Gtk::AboutDialog.new
        about.set_program_name "Scan Code"
        #about.set_comments "Battery is a simple tool for battery checking"
        about.set_logo GdkPixbuf::Pixbuf.new(:file => "tmp/qr.png")
        about.run
        about.destroy
    end

    def about_clicked
      about = Gtk::AboutDialog.new
      about.set_program_name "FineQR"
      about.set_comments "A QR Code generator"
      about.set_version "1.0.0"
      about.set_website "https://JijoBose.Github.io/"
      about.set_website_label "FineQR Project Website"
      about.set_logo GdkPixbuf::Pixbuf.new(:file => "image/Logo.png")
      #about.set_logo_icon_name "FineQR"
      about.set_authors ["Jijo Bose <bosejijo@gmail.com>"]
      about.set_copyright "Copyright (C) 2017 Jijo Bose"
      about.set_license "This program is licensed under BSD 3-Clause License\nCopyright (c) 2017, Jijo Bose\nAll rights reserved.\n\nTHIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\"\nAND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE\nIMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\nDISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE\nFOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL\nDAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR\nSERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER\nCAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,\nOR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE\nOF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
      about.run
      about.destroy
    end
end


window = FineQRApp.new
Gtk.main
