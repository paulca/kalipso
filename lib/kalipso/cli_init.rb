Jaysus::Local.store_dir = File.expand_path("~/.kalipso")
Jaysus::Local.store_dir.mkpath unless Jaysus::Local.store_dir.exist?

token_path = Jaysus::Local.store_dir.join('token')

if token_path.exist?
  token = token_path.read
else
  email = ask("Enter your email:  ") { |q| q.echo = true }
  password = ask("Enter your password:  ") { |q| q.echo = "*" }
  token = ActiveSupport::JSON.decode(RestClient.get("http://#{CGI.escape(email)}:#{CGI.escape(password)}@oncalypso.com/api/v1/users.json"))['token']
  token_path.open('w') do |file|
    file.write token
  end
end

Jaysus::Remote.base_url = "http://#{token}:x@oncalypso.com/api/v1"

if !Jaysus::Local.store_dir.join('keys').exist?
  key_dir = Jaysus::Local.store_dir.join('keys')
  key_dir.mkpath unless key_dir.exist?
  key_path = key_dir.join('id_rsa')
  public_key_path = key_dir.join('id_rsa.pub')
  puts "generating and uploading public key"
  `ssh-keygen -N '' -t rsa -q -f #{key_path.to_s.strip}`
  Kalipso::PublicKey::Remote.create(:key => public_key_path.read)
end