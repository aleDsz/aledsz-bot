import irc.message;
import std.format;

class Hello {
	string run(IRCMessage message) {
		return format("Olá, %s, seja bem-vindo :)", message.nickname);
	}
}
