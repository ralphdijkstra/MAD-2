<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use App\Models\User;
use Laravel\Sanctum\Sanctum;

class AuthenticationController extends Controller
{
    public function register(Request $request)
    {
        Log::info('register', ['ip' => $request->ip(), 'data' => $request->all()]);

        $attr = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|unique:users,email',
            'password' => 'required|string|min:6|confirmed'
        ]);

        $user = User::create([
            'name' => $attr['name'],
            'password' => bcrypt($attr['password']),
            'email' => $attr['email']
        ]);

        return response()->json(['message' => 'Registration successful'], 200);
    }
    public function login(Request $request)
    {
        Log::info('login', ['ip' => $request->ip(), 'data' => $request->all()]);

        $attr = $request->validate([
            'email' => 'required|string|email|',
            'password' => 'required|string|min:6'
        ]);
        if (!Auth::attempt($attr)) {
            return $this->error('Credentials not match', 401);
        }
        $response = [
            // 'access_token' => $request->bearerToken(),
            'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
            'token_type' => 'Bearer'
        ];
        return response()->json($response, 200);
    }
    public function logout(Request $request)
    {
        Log::info('logout', ['ip' => $request->ip(), 'data' => $request->all(), 'user' => auth()->user()]);

        auth()->user()->tokens()->delete();
        return [
            'message' => 'Tokens Revoked'
        ];
    }
}
