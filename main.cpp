bool SystemUp();

void OnError();

int main() {
	if (!SystemUp()) {
		OnError();
	}
        return 0;
}

