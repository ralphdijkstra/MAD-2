<?php

namespace App\Http\Controllers;

use App\Models\Werknemer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class WerknemerController extends Controller
{
    public function index(Request $request)
    {
        $request->user()->currentAccessToken()->delete();    // Verwijder de actuele token

        Log::info(
            'werknemers index',
            [
                'ip' => $request->ip(),
                'data' => $request->all()
            ]
        );

        if ($request->has('naam')) {
            $data = Werknemer::where('naam', 'like', '%' . $request->naam . '%')->get();
        } else if ($request->has('sort')) {
            $data =  Werknemer::orderBy($request->sort)->get();
        } else {
            $data = Werknemer::all();
            // $data = Werknemer::with('functie')->get();
        }
        $content = [
            'success' => true,
            'data'    => $data,
            'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
            'token_type' => 'Bearer',
        ];
        return response()->json($content, 200);
    }

    public function store(Request $request)
    {
        $request->user()->currentAccessToken()->delete();    // Verwijder de actuele token
        Log::info(
            'werknemers store',
            [
                'ip' => $request->ip(),
                'data' => $request->all(),
            ]
        );
        $validator = Validator::make($request->all(), [
            'email' => 'email',
            'naam' => 'required'
        ]);
        if ($validator->fails()) {
            Log::error("werknemers toevoegen Fout");
            $content = [
                'success' => false,
                'data'    => $request->all(),
                'foutmelding' => 'Data niet correct',
                'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
                'token_type' => 'Bearer',
            ];
            return response()->json($content, 400);
        } else {
            $content = [
                'success' => true,
                'data'    => Werknemer::create($request
                    ->only(['naam', 'functie_id', 'telefoon', 'email', 'sinds'])),
                'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
                'token_type' => 'Bearer',
            ];
            return response()->json($content, 201);
        }
    }


    public function show(Request $request, Werknemer $werknemer)
    {
        $request->user()->currentAccessToken()->delete();    // Verwijder de actuele token

        Log::info(
            'werknemers show',
            [
                'ip' => $request->ip(),
                'data' => $request->all()
            ]
        );

        $content = [
            'success' => true,
            'data'    => $werknemer,
            'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
            'token_type' => 'Bearer',
        ];
        return response()->json($content, 200);
    }


    public function update(Request $request, Werknemer $werknemer)
    {
        $request->user()->currentAccessToken()->delete();    // Verwijder de actuele token

        Log::info(
            'werknemers update',
            ['ip' => $request->ip(), 'oud' => $werknemer, 'nieuw' => $request->all()]
        );

        $validator = Validator::make($request->all(), [
            'naam' => 'required',
            'email' => 'email',
        ]);
        if ($validator->fails()) {
            Log::error("werknemers wijzigen Fout");
            $content = [
                'success' => false,
                'data'    => $request->all(),
                'foutmelding' => 'Gewijzigde data niet correct',
                'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
                'token_type' => 'Bearer',
            ];
            return response()->json($content, 400);
        } else {
            $content = [
                'success' => $werknemer->update($request->all()),
                'data'    => $request->only(['naam', 'functie_id', 'telefoon', 'email', 'sinds']),
                'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
                'token_type' => 'Bearer',
            ];
            return response()->json($content, 200);
        }
    }

    public function destroy(Request $request, Werknemer $werknemer)
    {
        $request->user()->currentAccessToken()->delete();    // Verwijder de actuele token

        Log::info(
            'werknemers destroy',
            ['ip' => $request->ip(), 'oud' => $werknemer]
        );
        $werknemer->delete();

        $content = [
            'success' => true,
            'data'    => $werknemer,
            'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
            'token_type' => 'Bearer',
        ];
        return response()->json($content, 202);
    }

    public function indexFunctie(Request $request, $id)
    {
        $request->user()->currentAccessToken()->delete();    // Verwijder de actuele token

        Log::info(
            'werknemers indexFunctie',
            [
                'ip' => $request->ip(),
                'data' => $request->all(),
                'id' => $id
            ]
        );
        if ($request->has('sort')) {
            $data =  Werknemer::where('functie_id', $id)->orderBy($request->sort)->get();
        } else {
            $data = Werknemer::where('functie_id', $id)->get();
        }

        $content = [
            'success' => true,
            'data'    => $data,
            'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
            'token_type' => 'Bearer',
        ];
        return response()->json($content, 200);
    }

    public function destroyFunctie(Request $request, $id)
    {
        $request->user()->currentAccessToken()->delete();    // Verwijder de actuele token

        Log::info(
            'werknemers destroyFunctie',
            [
                'ip' => $request->ip(),
                'data' => $request->all(),
                'functie id' => $id
            ]
        );
        Werknemer::where('functie_id', $id)->delete();

        $content = [
            'success' => true,
            'data'    => $id,
            'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
            'token_type' => 'Bearer',
        ];
        return response()->json($content, 202);
    }
}
