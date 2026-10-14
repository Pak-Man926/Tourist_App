package user.app.touristapp;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;


public class NightlifeFragment extends Fragment
{

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_nightlife, container, false);

        RecyclerView recyclerView = view.findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(getContext()));

        List<TouristSpot> spots = new ArrayList<>();
        spots.add(new TouristSpot("The Front Door Pub", "A lively bar with great drinks.", R.drawable.front_door));
        spots.add(new TouristSpot("Róisín Dubh", "Popular for live music events.", R.drawable.roisin_dubh));
        spots.add(new TouristSpot("The Quays", "Medieval interior with live bands.", R.drawable.the_quays));
        spots.add(new TouristSpot("Tig Cóilí", "Traditional Irish music and drinks.", R.drawable.tig_coili));
        spots.add(new TouristSpot("The Blue Note", "Quirky bar with a local vibe.", R.drawable.blue_note));
        spots.add(new TouristSpot("King's Head", "Traditional Irish music and drinks.", R.drawable.kings_head));


        TouristSpotAdapter adapter = new TouristSpotAdapter(getContext(), spots);
        recyclerView.setAdapter(adapter);

        return view;
    }
}