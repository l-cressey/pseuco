class ItemSet {
	Map<int, Item> items;
	int length;

	ItemSet() {
		this.items = {}
		this.length = 0
	}

	getShiftSymbols() {
		let symbols = {}
		for (let item in this.items) {
			let symbol = item.getShiftSymbol()
			symbols[symbol] = symbol
		}
		return symbols
	}

	addItem(item) {
		if (this.items[item.itemId] === undefined) {
			this.items[item.itemId] = item
			this.length += 1
		}
	}

	addItemSet(itemSet) {
		for (let item in itemSet.items) {
			if (this.items[item.itemId] === undefined) {
				this.items[item.itemId] = item
				this.length += 1
			}
		}
	}

	toString() {
		elementsString = this.items.join(",")
		return `ItemSet(${elementsString})`
	}
}

