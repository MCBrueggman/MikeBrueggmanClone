package com.example.jetpackcomposedemos.legacy

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

// MARK: - TODO 1: AccountsRepository interface

interface AccountsRepository {
    suspend fun transfer(
        from: Account,
        to: Account,
        amount: Double
    )
}

// MARK: - TODO 2: TransferEligibilityService and TransferFundsUseCase

class TransferEligibilityService {
    fun canTransfer(amount: Double, from: Account): Boolean {
        return amount > 0 && from.balance >= amount
    }
}

class TransferFundsUseCase @Inject constructor(
    private val repository: AccountsRepository,
    private val eligibilityService: TransferEligibilityService
) {
    suspend operator fun invoke(
        amount: Double,
        from: Account,
        to: Account
    ): Result<Unit> {
        if (!eligibilityService.canTransfer(amount, from)) {
            return Result.failure(
                IllegalArgumentException("Transfer is not eligible")
            )
        }

        return try {
            repository.transfer(from, to, amount)
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
}

// MARK: - TODO 3: TransferViewModel

sealed class TransferUiState {
    object Idle : TransferUiState()
    object Success : TransferUiState()
    data class Error(val message: String) : TransferUiState()
}

@HiltViewModel
class TransferViewModel @Inject constructor(
    private val transferFundsUseCase: TransferFundsUseCase
) : ViewModel() {

    private val _uiState = MutableStateFlow<TransferUiState>(
        TransferUiState.Idle
    )

    val uiState: StateFlow<TransferUiState> = _uiState.asStateFlow()

    fun attemptTransfer(
        amount: Double,
        from: Account,
        to: Account
    ) {
        viewModelScope.launch {
            _uiState.value = TransferUiState.Idle

            val result = transferFundsUseCase(
                amount = amount,
                from = from,
                to = to
            )

            _uiState.value = result.fold(
                onSuccess = {
                    TransferUiState.Success
                },
                onFailure = { error ->
                    TransferUiState.Error(
                        error.message ?: "Transfer failed"
                    )
                }
            )
        }
    }
}