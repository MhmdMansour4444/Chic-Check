<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use App\Models\User;

class UserController extends Controller
{
    public function showAllUsers()
    {
        $users = User::all();
        return response()->json($users);
    }

    public function getUser($id)
    {
        $user = User::findOrFail($id);

        return response()->json($user, 200);
    }

    public function update(Request $request)
    {
        $request->validate([
            'username' => 'required|string|max:50|unique:users,username,' . Auth::id(),
            'email' => 'required|email|unique:users,email,' . Auth::id(),
            'password' => 'nullable|string|min:6',
            'current_password' => 'required_with:password|string',
            'profile_pic' => 'nullable|image|max:2048',
            'preferences' => 'nullable|string',
        ]);

        $user = Auth::user();

        $user->username = $request->username;
        $user->email = $request->email;
        $user->preferences = $request->preferences;

        if ($request->filled('password')) {
            if (!Hash::check($request->current_password, $user->password)) {
                return response()->json(['error' => 'Current password is incorrect'], 400);
            }
            $user->password = Hash::make($request->password);
        }

        if ($request->hasFile('profile_pic')) {
            // Delete previous profile picture if exists
            if ($user->profile_pic) {
                Storage::delete($user->profile_pic);
            }

            // Store new profile picture in a folder named 'profile_pics'
            $profilePicPath = $request->file('profile_pic')->store('profile_pics', 'public');

            // Update user's profile picture path
            $user->profile_pic = $profilePicPath;
        }
        $user->save();

        return response()->json(['message' => 'User updated successfully'], 200);
    }



    public function delete($id)
    {
        $user = User::findOrFail($id);
        if ($user->profile_pic) {
            Storage::delete($user->profile_pic);
        }

        $user->delete();

        return response()->json(['message' => 'User deleted successfully'], 200);
    }
}
