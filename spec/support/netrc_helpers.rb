require 'netrc'

# during tests, I don't want to save/delete/overwrite my real netrc file
# so I'm operating on a temporary file at spec/support/.netrc
# which is gitignored and is deleted before each spec for good measure
def test_netrc_path
  current_dir = File.dirname(__FILE__)
  filename = File.join(current_dir, '.netrc')
  File.expand_path(filename)
end

def create_credentials_file
  f = File.open(test_netrc_path, 'w')
  f.write ''
  f.close
  File.chmod(0600, test_netrc_path)
  n = Netrc.read(test_netrc_path)
  yield n if block_given?
  n.save
end

def create_blank_credentials_file
  create_credentials_file
end

def create_valid_credentials_file(xid = 'boogaboo')
  GitSleep::Authorizer.instance.xid = xid
end

def create_unrelated_credentials_file
  create_credentials_file do |n|
    n['machine m'] = 'l', 'p'
  end
end

