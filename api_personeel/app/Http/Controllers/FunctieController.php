<?php

namespace App\Http\Controllers;

use App\Models\Functie;
use Illuminate\Http\Request;

class FunctieController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $response = [
            'success' => true,
            'data'    => Functie::All(),
            // 'data'    => Functie::with('werknemers')->get(),
        ];
        return response()->json($response, 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Functie $functie)
    {
        $response = [
            'success' => true,
            'data'    =>  $functie,
        ];
        return response()->json($response, 200);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Functie $functie)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Functie $functie)
    {
        //
    }
}
