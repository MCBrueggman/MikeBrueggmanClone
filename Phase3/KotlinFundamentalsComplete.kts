@file:DependsOn("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.11.0")
import kotlinx.coroutines.*

// MARK: TODO 1 — Account data class
data class Account(
    val id: String,
    val name: String,
    val balance: Double
)

// MARK: TODO 2 — TransferResult sealed class
sealed class TransferResult {
    data class Success(val confirmationId: String) : TransferResult()
    data class Failure(val reason: String) : TransferResult()
}

fun describe(result: TransferResult): String {
    return when (result) {
        is TransferResult.Success -> "Transfer successful: ${result.confirmationId}"
        is TransferResult.Failure -> "Transfer failed: ${result.reason}"
    }
}

// MARK: TODO 3 — Double.asCurrency() extension function
fun Double.asCurrency(): String {
    return "$%.2f".format(this)
}

// MARK: TODO 4 — suspend function simulating a network fetch
suspend fun fetchAccounts(): List<Account> {
    delay(500)

    return listOf(
        Account("001", "Checking", 4281.16),
        Account("002", "Savings", 12500.50),
        Account("003", "Credit Card", -342.75)
    )
}

// MARK: TODO 5 — collection operations
fun main() = runBlocking {
    val accounts = fetchAccounts()

    val overdraftAccounts = accounts.filter { it.balance < 0 }
    val totalBalance = accounts.sumOf { it.balance }

    println("Total balance: ${totalBalance.asCurrency()}")
    println("Overdraft accounts:")

    overdraftAccounts.forEach {
        println("${it.name}: ${it.balance.asCurrency()}")
    }
}

main()