import std.stdio;
import std.typecons;
import std.process;
import std.format;
import std.functional;
import twitchapid;
import hello;

void main() {
	string username = environment.get("TWITCH_USERNAME");
	string password = environment.get("TWITCH_PASSWORD");
	string channel = "aledsz";
	string host = "irc.chat.twitch.tv";
	ushort port = 6667;

	writeln("Connecting...");

	auto client = new IRCClient(host, port, username, password);
	client.connect();

	if (!client.connected()) {
		throw new Exception("Client not connected");
	}

	writeln(format("Connected with user: %s", username));

	client.join(channel);

	client.on(IRCMessage.Type.JOIN, (message) {
		message.reply("O PAI TA ON!");
	});

	client.on(IRCMessage.Type.PRIVMSG, r"(bom dia)", (message) {
		message.reply("Bom dia");
	});

	client.on(IRCMessage.Type.PRIVMSG, r"^!hello$", (message) {
		auto command = new Hello();
		auto text = command.run(message);
		message.reply(text);
	});

	client.on(IRCMessage.Type.PRIVMSG, (message) {
		writeln(format("%s: %s", message.nickname, message.text));
	});

	scope(exit) client.quit();

	client.run();
}

