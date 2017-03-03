require "gtk3"

def aboutpage

unless Gtk::Version.or_later?(3, 4, 2)
  puts "This sample requires GTK+ 3.4.2 or later: #{Gtk::Version::STRING}"
  exit
end

Gtk::AboutDialog.show(nil,
		      "artists" => ["Artist 1 <no1@foo.bar.com>", "Artist 2 <no2@foo.bar.com>"],
		      "authors" => ["Author 1 <no1@foo.bar.com>", "Author 2 <no2@foo.bar.com>"],
		      "comments" => "This is a sample script for Gtk::AboutDialog",
		      "copyright" => "Copyright (C) 2005 Ruby-GNOME2 Project",
		      "documenters" => ["Documenter 1 <no1@foo.bar.com>", "Documenter 2 <no2@foo.bar.com>"],
		      "license" => "This program is licenced under BSD 3-Clause License\nCopyright (c) 2017, Jijo Bose",
		      "logo_icon_name" => "gtk-home",
		      "program_name" => "Gtk::AboutDialog sample",
		      "translator_credits" => "Translator 1 <no1@foo.bar.com>\nTranslator 2 <no2@foo.bar.com>\n",
		      "version" => "1.0.0",
		      "website" => "http://ruby-gnome2.sourceforge.jp",
		      "website_label" => "Ruby-GNOME2 Project Website"
		      )

Gtk.main

end
