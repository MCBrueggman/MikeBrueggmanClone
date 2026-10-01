package com.example.jetpackcomposedemos

/*AccountListScreen_Starter.kt
Module 12 — Android UI Development
Lab Exercise: PNC Mobile — Accounts List Screen (Jetpack Compose)
*/

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.dp

// MARK: - Model

data class Account(
    val id: String,
    val name: String,
    val maskedNumber: String,
    val balance: Double
)

val sampleAccounts = listOf(
    Account("a1", "Everyday Checking", "\u2022\u2022\u2022\u2022 4471", 4281.16),
    Account("a2", "High Yield Savings", "\u2022\u2022\u2022\u2022 9902", 18340.50),
    Account("a3", "Rewards Credit Card", "\u2022\u2022\u2022\u2022 2216", -612.44)
)

// MARK: - TODO 1: AccountListScreen

@Composable
fun AccountListScreen(
    accounts: List<Account>,
    onAccountClick: (String) -> Unit
) {
    var showRefreshMessage by remember { mutableStateOf(false) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {

        Button(
            onClick = {
                showRefreshMessage = true
            }
        ) {
            Text("Refresh")
        }

        Spacer(modifier = Modifier.height(8.dp))

        AnimatedVisibility(
            visible = showRefreshMessage,
            enter = fadeIn(),
            exit = fadeOut()
        ) {
            Text(
                text = "Refreshed!",
                style = MaterialTheme.typography.bodyLarge,
                modifier = Modifier.padding(8.dp)
            )
        }

        Spacer(modifier = Modifier.height(8.dp))

        LazyColumn(
            modifier = Modifier.fillMaxSize()
        ) {
            items(
                items = accounts,
                key = { it.id }
            ) { account ->
                AccountRow(
                    account = account,
                    onClick = {
                        onAccountClick(account.id)
                    }
                )
            }
        }
    }
}

// MARK: - TODO 2: AccountRow

@Composable
fun AccountRow(
    account: Account,
    onClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(onClick = onClick)
            .semantics(mergeDescendants = true) {
                contentDescription =
                    "${account.name}, account number ${account.maskedNumber}, " +
                            "balance ${account.balance}"
            }
            .padding(16.dp)
    ) {
        Column(
            modifier = Modifier.weight(1f)
        ) {
            Text(
                text = account.name,
                style = MaterialTheme.typography.titleMedium
            )

            Text(
                text = account.maskedNumber,
                style = MaterialTheme.typography.bodyMedium
            )

            Text(
                text = "$${"%.2f".format(account.balance)}",
                style = MaterialTheme.typography.bodyLarge
            )
        }
    }
}